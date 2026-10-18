// Focus Loupe for FilmCraft (WGSL). Zoom and circle loupe; matches the DCTL's
// progress / zoom / target / loupeSize parameters. Target (0,0) = bottom-left.

struct Params {
  progress: f32,
  zoom: f32,
  target: vec2<f32>,
  loupe_size: f32,
  shape: u32, // 0 = full frame, 1 = circle
  aspect: f32, // width / height
  _pad: f32,
};

@group(0) @binding(0) var src: texture_2d<f32>;
@group(0) @binding(1) var samp: sampler;
@group(0) @binding(2) var<uniform> p: Params;

fn smooth_ease(t: f32) -> f32 {
  return t * t * (3.0 - 2.0 * t);
}

@fragment
fn fs_main(@location(0) uv: vec2<f32>) -> @location(0) vec4<f32> {
  let t = smooth_ease(clamp(p.progress, 0.0, 1.0));
  let z = mix(1.0, p.zoom, t);
  let target_uv = vec2<f32>(p.target.x, 1.0 - p.target.y);
  let zoomed = target_uv + (uv - target_uv) / z;

  if (p.shape == 0u) {
    return textureSample(src, samp, zoomed);
  }
  let d = (uv - target_uv) * vec2<f32>(p.aspect, 1.0);
  let r = 0.5 * p.loupe_size * t;
  let inside = 1.0 - smoothstep(r - 0.002, r, length(d));
  return mix(textureSample(src, samp, uv), textureSample(src, samp, zoomed), inside);
}
