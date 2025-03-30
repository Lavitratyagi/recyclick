<script lang="ts">
	import '../app.css';

	let { children } = $props();
</script>

<div class="app text-black">
	<main>
		{@render children()}
	</main>
</div>
