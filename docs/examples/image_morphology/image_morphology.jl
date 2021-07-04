# ---
# title: Morphological Operations
# author: Ashwani Rathee
# date: 2021-7-2
# ---

# Morphological image processing is a area of computer vision which pursue tophat
# remove imperfections from binary and grayscale images. ImageMorphology.jl
# holds a collection of non-linear operations related to the shape or
# morphology of features in an image.

# In this demonstration, we cover the 6 most common morphological operations:
# - Erosion
# - Dilation
# - Opening
# - Closing
# - Tophat
# - Bothat 
# - Morphological Gradient
# - Morphological Laplace

# Let's import an image 

using Images, ImageView, ImageMorphology, TestImages, MosaicViews

img = testimage("morphology_test_512")

# This is an RGB image, which we would need to be convert to either grayscale
# binary image as morphology functions only work on grayscale or binary images.

# ## Erosion

# Erode performs perform a min-filter over nearest-neighbors. The default 
# is 8-connectivity in 2d, 27-connectivity in 3d, etc. You can specify 
# the list of dimensions that you want to include in the connectivity,
#  e.g., `region = [1,2]` would exclude the third dimension from filtering.

img_erode = Gray.(Gray.(img) .< 0.8); # keeps white objects white
img_erosion1 = erode(img_erode)
img_erosion2 = erode(erode(img_erode))
img_erosion3 = erode(erode(erode(img_erode)))
mosaicview(img_erode, img_erosion1, img_erosion2, img_erosion3; nrow = 1)

# ## Dilation

# Dilate performs a max-filter over nearest-neighbors. The default is 
# 8-connectivity in 2d, 27-connectivity in 3d, etc. You can specify the
# list of dimensions that you want to include in the connectivity,
#  e.g., `region = [1,2]` would exclude the third dimension from filtering.

img_dilate = Gray.(1 * Gray.(img) .> 0.9);
img_dilate1 = dilate(img_dilate)
img_dilate2 = dilate(dilate(img_dilate))
img_dilate3 = dilate(dilate(dilate(img_dilate)))
mosaicview(img_dilate, img_dilate1, img_dilate2, img_dilate3; nrow = 1)


# ## Opening

# Opening morphology operation is equivalent to `dilate(erode(img))`.
# In opening(img, [region]), `region` allows you to control the 
# dimensions over which this operation is performed. Opening can remove 
# small bright spots (i.e. “salt”) and connect small dark cracks.

img_opening = Gray.(1 * Gray.(img) .> 0.5);
img_opening1 = opening(img_opening)
img_opening2 = opening(opening(img_opening))
img_opening3 = opening(opening(opening(img_opening)))
mosaicview(img_opening, img_opening1, img_opening2, img_opening3; nrow = 1)

# ## Closing

# Closing morphology operation is equivalent to `erode(dilate(img))`.
# In closing(img, [region]),`region` allows you to control the dimensions
# over which this operation is performed. Closing can remove small dark
# spots (i.e. “pepper”) and connect small bright cracks.

img_closing = Gray.(1 * Gray.(img) .> 0.5);
img_closing1 = closing(img_closing)
img_closing2 = closing(closing(img_closing))
img_closing3 = closing(closing(closing(img_closing)))
mosaicview(img_closing1, img_closing1, img_closing2, img_closing3; nrow = 1)

# ## Tophat

# Tophat is defined as the image minus its morphological opening.
# In tophat(img, [region]),`region` allows you to control the dimensions
# over which this operation is performed. This operation returns the bright
# spots of the image that are smaller than the structuring element.

img_tophat = Gray.(1 * Gray.(img) .> 0.2);
img_tophat1 = tophat(img_tophat)
img_tophat2 = tophat(tophat(img_tophat))
mosaicview(img_tophat, img_tophat1, img_tophat2; nrow = 1)

# ## Bottom Hat

# Bottom Hat morphology operation is defined as its morphological closing
# minus the original image.
# In bothat(img, [region]),`region` allows you to control the dimensions
# over which this operation is performed.  This operation returns the 
# dark spots of the image that are smaller than the structuring element.

img_bothat = Gray.(1 * Gray.(img) .> 0.5);
img_bothat1 = bothat(img_tophat)
img_bothat2 = bothat(bothat(img_tophat))
img_bothat3 = bothat(bothat(bothat(img_tophat)))
mosaicview(img_bothat, img_bothat1, img_bothat2; nrow = 1)

# ## Morphology Gradient
# Morphological gradient returns morphological gradient of the image,
# which is the difference between the dilation and the erosion of a 
# given image. In morphogradient(img, [region]),`region` allows you to
# control the dimensions over which this operation is performed.

img_gray = Gray.(0.8 * Gray.(img) .> 0.7);
img_morphograd = morphogradient(Gray.(0.8 * Gray.(img) .> 0.4))
mosaicview(img_gray, img_morphograd; nrow = 1)

# ## Morphological Laplace
# Morphological Laplace performs `Morphological Laplacian` of an image,
# which is defined as the arithmetic difference between the internal and 
# the external gradient. In morpholaplace(img, [region])`,`region` allows
# you to control the dimensions over which this operation is performed.

img_gray = Gray.(0.8 * Gray.(img) .> 0.7);
img_morpholap = morpholaplace(img_gray)
mosaicview(img_gray, img_morpholap; nrow = 1)
