# test-harness

Golden-image tests: render one frame of a plugin with fixed parameters, then compare it
to the golden image in `golden/`.

- Goldens are named `golden/<plugin>/<case>.<png|exr>` and stored with Git LFS
  (see `golden/.gitattributes`). Run `git lfs install` once before cloning.
- A case fails when the render differs from its golden beyond the case's tolerance.
- To update a golden, render it, check it by eye, and commit it in the same PR as the
  change that caused it, explaining why it changed.

TODO: the render-and-compare runner (Resolve render queue for DCTL, FilmCraft
`render_frame` over MCP for WGSL).
