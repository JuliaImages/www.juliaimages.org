# ---
# cover: assets/brisk.gif
# title: BRISK Descriptor
# description: This demo shows BRISK descriptor
# author: Anchit Navelkar; Ashwani Rathee
# date: 2021-07-12
# ---

# The *BRISK* (Binary Robust Invariant Scalable Keypoints) descriptor has a predefined 
# sampling pattern as compared to [BRIEF](brief.md) or [ORB](orb.md). 
# Pixels are sampled over concentric rings. For each sampling point, a small patch 
# is considered around it. Before starting the algorithm, the patch is smoothed 
# using gaussian smoothing.

# Two types of pairs are used for sampling, short and long pairs. 
# Short pairs are those where the distance is below a set threshold distmax while the
# long pairs have distance above distmin. Long pairs are used for orientation and 
# short pairs are used for calculating the descriptor by comparing intensities.

# BRISK achieves rotation invariance by trying the measure orientation of the keypoint
# and rotating the sampling pattern by that orientation. This is done by first 
# calculating the local gradient `g(pi,pj)` between sampling pair `(pi,pj)` where 
# `I(pj, pj)` is the smoothed intensity after applying gaussian smoothing.

# `g(pi, pj) = (pi - pj) . I(pj, j) -I(pj, j)pj - pi2`

# All local gradients between long pairs and then summed and the `arctangent(gy/gx)`
# between `y` and `x` components of the sum is taken as the angle of the keypoint. 
# Now, we only need to rotate the short pairs by that angle to help the descriptor 
# become more invariant to rotation.
# The descriptor is built using intensity comparisons. For each short pair if the 
# first point has greater intensity than the second, then 1 is written else 0 is 
# written to the corresponding bit of the descriptor.

# ## Example

# Let us take a look at a simple example where the BRISK descriptor is used to 
# match two images where one has been translated by `(50, 40)` pixels and then 
# rotated by an angle of 75 degrees. We will use the `lighthouse` image from the
#  [TestImages](https://github.com/timholy/TestImages.jl) package for this example.

# First, let us create the two images we will match using BRISK.

using ImageFeatures, TestImages, Images, ImageDraw, CoordinateTransformations, Rotations
using MosaicViews

img = testimage("lake_color")

# Original Image 

img1 = Gray.(img)
rot = recenter(RotMatrix(5pi/6), [size(img1)...] .÷ 2)  # a rotation around the center
tform = rot ∘ Translation(-50, -40)
img2 = warp(img1, tform, axes(img1))
mosaicview(img, img1, img2; nrow=1)

# To calculate the descriptors, we first need to get the keypoints. For this 
# tutorial, we will use the FAST corners to generate keypoints (see [`fastcorners`](@ref)).


features_1 = Features(fastcorners(img1, 12, 0.35))
features_2 = Features(fastcorners(img2, 12, 0.35))

# To create the BRISK descriptor, we first need to define the parameters by 
# calling the [`BRISK`](@ref) constructor.


brisk_params = BRISK()


# Now pass the image with the keypoints and the parameters to the 
# [`create_descriptor`](@ref) function.

desc_1, ret_features_1 = create_descriptor(img1, features_1, brisk_params)
desc_2, ret_features_2 = create_descriptor(img2, features_2, brisk_params)

# The obtained descriptors can be used to find the matches between the two 
# images using the [`match_keypoints`](@ref) function.

matches = match_keypoints(Keypoints(ret_features_1), Keypoints(ret_features_2), desc_1, desc_2, 0.1)

# We can use the [ImageDraw.jl](https://github.com/JuliaImages/ImageDraw.jl) package to view the results.

grid = hcat(img1, img2)
offset = CartesianIndex(0, size(img1, 2))
map(m -> draw!(grid, LineSegment(m[1], m[2] + offset)), matches)
grid

save("assets/brisk.gif", cat(img, img2, grid[1:512,1:512], grid[1:512,513:1024]; dims=3); fps=2) #src