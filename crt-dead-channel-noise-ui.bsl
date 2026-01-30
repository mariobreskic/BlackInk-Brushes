cfg {
    name = "CRT Dead Channel Noise (UI)";
    renderingTime = 60;
}

globals {

    float intensity = 1;
    {
        uiTab = "CRT";
        uiName = "Intensity";
        uiEditor = slider;
        uiMin = 0;
        uiMax = 2;
    }

    float contrast = 1;
    {
        uiTab = "CRT";
        uiName = "Contrast";
        uiEditor = slider;
        uiMin = 0.2;
        uiMax = 3;
    }

    float scanFreq = 800;
    {
        uiTab = "CRT";
        uiName = "Scanline Frequency";
        uiEditor = slider;
        uiMin = 100;
        uiMax = 2000;
    }

    float noiseFreq = 400;
    {
        uiTab = "CRT";
        uiName = "Noise Frequency";
        uiEditor = slider;
        uiMin = 50;
        uiMax = 1000;
    }
}

float hash(float2 p)
{
    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

float4 main(idatas i)
{
    box2 b = box2FromCenterAxe(
        i.strokeStartPos,
        length(i.strokePos - i.strokeStartPos),
        normalizeSafe(i.strokePos - i.strokeStartPos)
    );

    float2 uv = b.toCenter(i.pos) / max(b.size, EPSILON);

    float scan = 0.5 + 0.5 * sin(uv.y * scanFreq);

    float n = hash(floor(uv * noiseFreq));

    float flicker = 0.85 + 0.15 * sin(i.time * 40);

    float bw = step(0.5, n);
    bw = pow(bw, 1.0 / contrast);

    float v = bw * scan * flicker * intensity;

    return float4(v, v, v, 1.0);
}
