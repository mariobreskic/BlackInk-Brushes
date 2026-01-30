cfg {
    name = "CRT RGB Subpixel Snow";
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

    float subpixelShift = 0.002;
    {
        uiTab = "CRT";
        uiName = "Subpixel Shift";
        uiEditor = slider;
        uiMin = 0;
        uiMax = 0.01;
    }
}

float hash(float2 p)
{
    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

float bwNoise(float2 uv, float freq)
{
    return step(0.5, hash(floor(uv * freq)));
}

float4 main(idatas i)
{
    // Canvas-locked space
    float2 uv = i.pos * 0.002;

    float scan = 0.5 + 0.5 * sin(uv.y * scanFreq);
    float flicker = 0.85 + 0.15 * sin(i.time * 40);

    float r = bwNoise(uv + float2(-subpixelShift, 0), noiseFreq);
    float g = bwNoise(uv,                         noiseFreq);
    float b = bwNoise(uv + float2( subpixelShift, 0), noiseFreq);

    r = pow(r, 1.0 / contrast);
    g = pow(g, 1.0 / contrast);
    b = pow(b, 1.0 / contrast);

    float3 col = float3(r, g, b) * scan * flicker * intensity;

    return float4(col, 1.0);
}

