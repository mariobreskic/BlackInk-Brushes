cfg {
	name = "Dead Channel Noise";
	renderingTime = 60;
}

float hash(float2 p)
{
	// Simple deterministic noise
	return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

float4 main(idatas i)
{
	// Stroke-aligned box (same approach as DEBUG Vertical RGB Stripes)
	box2 b = box2FromCenterAxe(
		i.strokeStartPos,
		length(i.strokePos - i.strokeStartPos),
		normalizeSafe(i.strokePos - i.strokeStartPos)
	);

	// Stroke-space UVs
	float2 uv = b.toCenter(i.pos) / max(b.size, EPSILON);

	// --- CRT characteristics ---

	// Horizontal scanlines
	float scan = 0.5 + 0.5 * sin(uv.y * 800);

	// Static noise (stable in stroke space)
	float n = hash(floor(uv * 400));

	// Flicker over time
	float flicker = 0.85 + 0.15 * sin(i.time * 40);

	// Black / white noise mix
	float bw = step(0.5, n);

	// Combine all effects
	float intensity = bw * scan * flicker;

	float3 col = float3(intensity, intensity, intensity);

	return float4(col, 1.0);
}
