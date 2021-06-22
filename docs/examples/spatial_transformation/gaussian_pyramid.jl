# ---
# cover: assets/lake_color.tif
# title: Gaussian Pyramid
# author: Park ma
# date: 2021-5-24
# ---

# This demo illustrates the use of [Gaussian Pyramid](https://juliaimages.org/stable/function_reference/#Images.gaussian_pyramid)

# Gaussian Pyramid is a technique in image processing that breaks down 
# an image into successively smaller groups of pixels to blur it. 

using TestImages,Images

img = testimage("lake_color")

# We will build image pyramids though the Gaussian Pyramid.

img_pyramids = gaussian_pyramid(img,5,2,2.0)

mosaicview(img_pyramids...;nrow=1,rowmajor=true)

# ---save covers ---#src
using FileIO #src
save("assets/lake_color.tif",img)#src



