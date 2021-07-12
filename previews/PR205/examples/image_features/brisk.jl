using ImageFeatures, TestImages, Images, ImageDraw, CoordinateTransformations, Rotations
using MosaicViews

img = testimage("lake_color")

img1 = Gray.(img)
rot = recenter(RotMatrix(5pi/6), [size(img1)...] .÷ 2)  # a rotation around the center
tform = rot ∘ Translation(-50, -40)
img2 = warp(img1, tform, axes(img1))
mosaicview(img, img1, img2; nrow=1)

features_1 = Features(fastcorners(img1, 12, 0.35))
features_2 = Features(fastcorners(img2, 12, 0.35))

brisk_params = BRISK()

desc_1, ret_features_1 = create_descriptor(img1, features_1, brisk_params)
desc_2, ret_features_2 = create_descriptor(img2, features_2, brisk_params)

matches = match_keypoints(Keypoints(ret_features_1), Keypoints(ret_features_2), desc_1, desc_2, 0.1)

grid = hcat(img1, img2)
offset = CartesianIndex(0, size(img1, 2))
map(m -> draw!(grid, LineSegment(m[1], m[2] + offset)), matches)
grid

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

