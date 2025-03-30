from typing import List, Any, Optional
import os

from pymongo.collection import Collection, Mapping
from fastapi import FastAPI, File, HTTPException, UploadFile, WebSocket, WebSocketDisconnect
from pymongo import MongoClient
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import ollama

from concurrent.futures import ThreadPoolExecutor

executor = ThreadPoolExecutor(max_workers=4)  # Adjust based on your hardware

client = ollama.AsyncClient()

ROLE = {
    'customer': 'customer',
    'vendor': 'vendor',
    'collector_company': 'collector_company',
    'company': 'company'
}

collection_center = []
vendor = []
company = []


class User(BaseModel):
    aadhar: int
    name: str
    phone_number: str
    password: str
    city: str


class Order(BaseModel):
    aadhar: int
    image_url: Optional[str]
    type: str
    company: str
    model: str
    variant: str
    imei: Optional[str]
    color: str
    status: int = 0


class Mymongo(FastAPI):
    mongodb_client: MongoClient
    collection_customer: Collection[Mapping[str, Any]]
    collection_device: Collection[Mapping[str, Any]]
    collection_vendor: Collection[Mapping[str, Any]]
    collection_collector_company: Collection[Mapping[str, Any]]
    collection_company: Collection[Mapping[str, Any]]
    db: Any


app = Mymongo()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


run_enironment = os.environ.get('local')
if run_enironment:
    DB_URL = 'mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.4.0'
else:
    DB_URL = 'mongodb+srv://test:test@cluster0.yvlq9mj.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'


@app.on_event('startup')
async def startup_client():
    app.mongodb_client = MongoClient(DB_URL)
    app.db = app.mongodb_client['ewaste']
    app.collection_customer = app.mongodb_client['ewaste']['customer']
    app.collection_device = app.mongodb_client['ewaste']['device']
    app.collection_vendor = app.mongodb_client['ewaste']['vendor']
    app.collection_collector_company = app.mongodb_client['ewaste']['collector_company']
    app.collection_company = app.mongodb_client['ewaste']['company']


@app.on_event("shutdown")
def shutdown_db_client():
    app.mongodb_client.close()


@app.post('/account/{role}/create')
async def create(user: User, role: str):
    collection = ROLE.get(role)
    if not collection:
        print('returning false')
        return False
    if (app.db[collection].find_one({"aadhar": user.aadhar})):
        return False
    app.collection_customer.insert_one({
        'aadhar': user.aadhar,
        'name': user.name,
        'phone_number': user.phone_number,
        'password': user.password,
        'city': user.city,
    })
    return True


@app.get('/account/{role}/login')
async def login(aadhar: int, password: str, role: str):
    collection = ROLE.get(role)
    if not collection:
        return False
    if (app.db[collection].find_one(
        {
            'aadhar': aadhar,
            'password': password
        }
    )):
        return True
    return False


@app.get('/account/{role}/info')
async def info(aadhar: int, role: str):
    collection = ROLE.get(role)
    if not collection:
        return False
    if (usr := app.db[collection].find_one({"aadhar": aadhar})):
        return User(
            aadhar=usr.get("aadhar", ""),
            name=usr.get("name", ""),
            phone_number=usr.get("phone_number", ""),
            password=usr.get("password", ""),
            city=usr.get("city", ""),
        )
    return {}


@app.post('/order/create')
async def create_order(order: Order):
    if app.db['customer'].find_one({"aadhar": order.aadhar}):
        inserted = app.collection_device.insert_one({
            'customer_id': order.aadhar,
            'type': order.type,
            'image_url': order.image_url,
            'company': order.company,
            'model': order.model,
            'variant': order.variant,
            'imei': order.imei,
            'color': order.color,
        })

        return str(inserted.inserted_id)
    return False


@app.get('/order/{id}/info')
async def order_info(id: str):
    if (order := app.collection_device.find_one({"_id": id})):
        return Order(
            aadhar=order.get("customer_id", ""),
            image_url=order.get("image_url", ""),
            type=order.get("type", ""),
            company=order.get("company", ""),
            model=order.get("model", ""),
            variant=order.get("variant", ""),
            imei=order.get("imei", ""),
            color=order.get("color", ""),
        )
    return {}


@app.post('/ai/image')
async def img(file: UploadFile = File(...)):
    if not file.content_type.startswith('image/'):  # type: ignore
        raise HTTPException(400, detail="Invalid file type")

    response = await client.generate(model='llama3.2-vision',
                                     prompt="tell me wether the object is damaged or not?",
                                     images=[await file.read()]
                                     )
    print(response['response'].strip())

    return response['response'].strip()


@app.get('/ai/gist/{query}')
async def chatbot(query: str):
    response: ollama.ChatResponse = await client.chat(model='llama3.2', messages=[
        {
            'role': 'system',
            'content': "give asked device detailed component list for recycling and how much it will cost to environment add a label environmental_impact: level 1, level 2, level 3",
        },
        {
            'role': 'user',
            'content': query,
        },
    ])
    return response.message.content


@app.get('/track/{order_id}/status')
async def track_status(order_id: str) -> int:
    if (order := app.collection_device.find_one({"_id": order_id})):
        return int(order.get("status", 0))
    return False


@app.get('/track/{role}')
async def get_track_lvl(role: str):
    if (rle := ROLE.get(role)):
        if rle == 'company':
            return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        elif rle == 'collector_company':
            return [1, 2, 6, 7]
        elif rle == 'vendor':
            return [3, 4, 5]


@app.get('/track/{role}/{lvl}/{order_id}')
async def update_track(role: str, lvl: int, order_id: str):
    if (rle := ROLE.get(role)):
        if rle == 'company':
            if lvl in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]:
                app.collection_device.update_one(
                    {"_id": order_id},
                    {"$set": {"status": lvl}}
                )
                return True
        elif rle == 'collector_company':
            if lvl in [1, 2, 6, 7]:
                app.collection_device.update_one(
                    {"_id": order_id},
                    {"$set": {"status": lvl}}
                )
                return True
        elif rle == 'vendor':
            if lvl in [3, 4, 5]:
                app.collection_device.update_one(
                    {"_id": order_id},
                    {"$set": {"status": lvl}}
                )
                return True
    return False


@app.get('/add/vendor/{order_id}')
async def add_vendor(order_id: str):
    vendor.append(order_id)
    return True


@app.get('/get/vendor/{order_id}')
async def get_vendor(order_id: str):
    if order_id in vendor:
        return True
    return False


@app.get('/add/collection_center/{order_id}')
async def add_collection_center(order_id: str):
    vendor.remove(order_id)
    collection_center.append(order_id)
    return True


@app.get('/get/collection_center/{order_id}')
async def get_collection_center(order_id: str):
    if order_id in collection_center:
        return True
    return False


@app.get('/add/company/{order_id}')
async def add_company(order_id: str):
    collection_center.remove(order_id)
    company.append(order_id)
    return True


@app.get('/get/company/{order_id}')
async def get_company(order_id: str):
    if order_id in company:
        return True
    return False


class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        if websocket in self.active_connections:
            self.active_connections.remove(websocket)

    async def broadcast_bytes(self, message: bytes, sender: WebSocket | None = None):
        for connection in self.active_connections.copy():
            if connection != sender:
                try:
                    await connection.send_bytes(message)
                except Exception:
                    self.disconnect(connection)

    async def send_personal_message(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)

    async def broadcast(self, message: str, sender: WebSocket | None = None):
        for connection in self.active_connections.copy():
            if connection != sender:
                try:
                    await connection.send_text(message)
                except Exception:
                    self.disconnect(connection)


manager = ConnectionManager()


@app.websocket("/broadcast/alerts")
async def broadcast(websocket: WebSocket):
    await manager.connect(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            await manager.broadcast(data)
    except WebSocketDisconnect:
        manager.disconnect(websocket)
    except Exception as e:
        manager.disconnect(websocket)
        raise e


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
