using ImageFeatures, TestImages, Images, ImageDraw, CoordinateTransformations

img = testimage("sudoku")
img1 = Gray.(img)
trans = Translation(-50, -50)
img2 = warp(img1, trans, axes(img1))

keypoints_1 = Keypoints(fastcorners(img1, 12, 0.4))
keypoints_2 = Keypoints(fastcorners(img2, 12, 0.4))

brief_params = BRIEF(size = 256, window = 10, seed = 123)

desc_1, ret_keypoints_1 = create_descriptor(img1, keypoints_1, brief_params)
desc_2, ret_keypoints_2 = create_descriptor(img2, keypoints_2, brief_params)

matches = match_keypoints(ret_keypoints_1, ret_keypoints_2, desc_1, desc_2, 0.1)

grid = hcat(img1, img2)
offset = CartesianIndex(0, size(img1, 2))
map(m -> draw!(grid, LineSegment(m[2] + offset,m[1] )), matches)
grid

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

