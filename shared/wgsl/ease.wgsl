// Easing curves shared by Spear Fia WGSL shaders. t in [0, 1].
fn sf_ease_smooth(t: f32) -> f32 { return t * t * (3.0 - 2.0 * t); }
fn sf_ease_smoother(t: f32) -> f32 { return t * t * t * (t * (t * 6.0 - 15.0) + 10.0); }
