using ImageFeatures, TestImages, Images, ImageDraw, CoordinateTransformations, Rotations

img = testimage("peppers_color")

img1 = Gray.(img)
rot = recenter(RotMatrix(5pi/6), [size(img1)...] .÷ 2)  # a rotation around the center
tform = rot ∘ Translation(-50, -40)
img2 = warp(img1, tform, axes(img1))

keypoints_1 = Keypoints(fastcorners(img1, 12, 0.35))
keypoints_2 = Keypoints(fastcorners(img2, 12, 0.35))

freak_params = FREAK()

desc_1, ret_keypoints_1 = create_descriptor(img1, keypoints_1, freak_params)
desc_2, ret_keypoints_2 = create_descriptor(img2, keypoints_2, freak_params)

matches = match_keypoints(ret_keypoints_1, ret_keypoints_2, desc_1, desc_2, 0.1)

grid = hcat(img1, img2)
offset = CartesianIndex(0, size(img1, 2))
map(m -> draw!(grid, LineSegment(m[1], m[2] + offset)), matches)
grid

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

