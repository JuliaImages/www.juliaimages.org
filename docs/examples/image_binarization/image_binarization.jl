# ---
# title: Image Binarization
# author: Ashwani Rathee
# date: 2021-7-2
# ---

# ImageBinarization.jl provides number of algorithms for binarizing images
# into background and foreground(bi-level image). In this demonstration , 
# we'll be exploring where these algorithms could be useful and learn how
# different algorithms are suited for different types of tasks.

# Suppose a person wants to make a automatic Sudoku solver using Computer 
# Vision . Before anything else that person needs to import the image, 
# preprocess it to optimize it for cell content extraction which can then 
# be used for solving the sudoku. 

# Let's first import our sudoku

using ImageBinarization, TestImages, MosaicViews, Colors
using ImageTransformations, CoordinateTransformations, Rotations, ImageMorphology

# Original Image

img = testimage("sudoku")

# Grayscale version as binarize! only accepts Grayscale images

img = Gray.(img)

# Let's first rotate our image
trfm = recenter(RotMatrix(pi/30), center(img));
imgw = warp(img, trfm)

# Now lets zoom in a bit

imgw = parent(imgw)[65:490,65:490]

# Now let's binarize a image using Sauvola algorithm

alg = Sauvola();
img_otsu = binarize(imgw, alg)
[imgw img_otsu]

# Now the differences between the binarized and non-binarized images 
# become apparent. Let's now implement a function to see how different algorithms 
# perform for this particular problem.

algs = [
    "AdaptiveThreshold",
    "Balanced",
    "Entropy",
    "Intermodes",
    "MinimumError",
    "Moments",
    "Niblack",
    "Otsu",
    "Polysegment",
    "Sauvola",
    "UnimodalRosin",
    "Yen",
]
function binarize_methods(img_input, algs)
    imgs_binarized = Array[]
    for i in algs
        alg = getfield(ImageBinarization, Symbol(i))()
        img_input1 = binarize(img_input, alg)
        push!(imgs_binarized, img_input1)
    end
    return imgs_binarized
end

output = binarize_methods(imgw, algs)
mosaicview(output, nrow = 3, npad = 1)



