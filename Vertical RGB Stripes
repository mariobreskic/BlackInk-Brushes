cfg {
	name = "Vertical RGB Stripes";
	renderingTime = 60;
}

float4 main(idatas i) {
	// Normalize stroke space UVs
	box2 b = box2FromCenterAxe(i.strokeStartPos, length(i.strokePos - i.strokeStartPos), normalizeSafe(i.strokePos - i.strokeStartPos));
	float2 uv = 4 * b.toCenter(i.pos) / b.size;

	// Scale up horizontal frequency
	float stripe = floor(uv.x * 60); // visible stripes

	// Simple stripe pattern: R, G, B
	float3 col = float3(0.0, 0.0, 0.0);
	if (mod(stripe, 3) == 0) {
		col.r = 1.0;
	} else if (mod(stripe, 3) == 1) {
		col.g = 1.0;
	} else {
		col.b = 1.0;
	}

	return float4(col, 1.0);
}
