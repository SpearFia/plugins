// Easing curves shared by Spear Fia DCTLs. t in [0, 1].
__DEVICE__ float sf_ease_smooth(float t) { return t * t * (3.0f - 2.0f * t); }
__DEVICE__ float sf_ease_smoother(float t) { return t * t * t * (t * (t * 6.0f - 15.0f) + 10.0f); }
