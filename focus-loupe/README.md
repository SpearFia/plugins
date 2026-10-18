# Focus Loupe

`spearfia/focus-loupe@0.1.0`: zoom, punch-in and magnifier loupe.

Capabilities (see `focus-loupe.asset.json`):

- `pip.face-circle`: circular picture-in-picture that follows a face. Requires the
  `face_track` analysis; binds `center` and `radius` to it.
- `zoom.punch-in`: full-frame punch-in on a target point.

| Format | Status |
| --- | --- |
| `dctl/` | `FocusLoupe.dctl` v1.0.1, imported from the video-editing-harness vault. **Not yet confirmed** to build in the ResolveFX DCTL plugin or to play back at full speed. |
| `ofx/` | Placeholder (CMake project, no code). |
| `wgsl/` | Starter shader for FilmCraft: zoom and circle loupe only. |

## Install (Resolve)

```powershell
.\scripts\install.ps1 -Plugin focus-loupe
```

Then on the Edit page: Effects ▸ OpenFX ▸ ResolveFX Color ▸ DCTL, drop it on a clip,
pick `SpearFia ▸ FocusLoupe` in the DCTL list, and press **Reset** after any file change.

Development history, benchmarks and validation notes stay in the private
`video-editing-harness` repo.
