# ---
# title: Image Binarization
# author: Ashwani Rathee
# date: 2021-7-2
# ---

# ImageBinarization.jl provides several algorithms for binarizing images
# into background and foreground(bi-level image). In this demonstration, 
# we'll be exploring where these algorithms could be useful and learn how
# different algorithms are suited for different types of tasks.

# Suppose a person wants to make an automatic Sudoku solver using Computer 
# Vision . Before anything else that person needs to import the image, 
# preprocess it to optimize it for cell content extraction which can then 
# be used for solving the sudoku. 

# Let's first import packages and then testimage sudoku

using Images, ImageBinarization, TestImages
using  CoordinateTransformations, Rotations, ImageTransformations

# Original Image

img = testimage("sudoku")

# Grayscale version as binarize! only accepts Grayscale images

img = Gray.(img)

# Let's first rotate our image

trfm = recenter(RotMatrix(pi / 30), center(img));
imgw = warp(img, trfm)

# Now let's zoom in a bit

imgw = parent(imgw)[65:490, 65:490]

# Now let's binarize an image using the `Sauvola` algorithm

alg = Sauvola();
img_otsu = binarize(imgw, alg)
mosaicview(imgw, img_otsu; ncol = 2)

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

output = binarize_methods(imgw, algs);


for i = 1:12 #src
    save("assets/test$(i).png", RGB.(output[i])) #src
end #src

# | Algorithm | Algorithm | Algorithm |
# | :------: | :------: | :------: |
# | AdaptiveThreshold | Balanced | Entropy |
# | ![](assets/test1.png)  | ![](assets/test2.png)  | ![](assets/test3.png) |
# | MinimumError |  Moments | Niblack |
# | ![](assets/test5.png) | ![](assets/test6.png) | ![](assets/test7.png) |
# | Polysegment | Sauvola | UnimodalRosin |
# | ![](assets/test9.png) | ![](assets/test10.png) | ![](assets/test11.png) |
# | Intermodes | Otsu | Yen |
# | ![](assets/test4.png) | ![](assets/test8.png) | ![](assets/test12.png) |

# We can choose one of methods based on the results here, and use `OCReact.jl` 
# which is based on Tesseract OCR to find the content in the sudoku and then
# solve the sudoku.

# Now let's take a simple example to understand the behavior of these algorithms
# 

img = Array(reshape(range(0, stop = 1, length = 4 * 10^4), 200, 200))
img = Gray.(img)

# Implementation of algorithms on this example

output = binarize_methods(img, algs);

for i = 1:12 #src
    save("assets/test$(i+12).png", RGB.(output[i])) #src
end #src

# | Algorithm | Algorithm | Algorithm |
# | :------: | :------: | :------: |
# | AdaptiveThreshold | Balanced | Entropy |
# | ![](assets/test13.png)  | ![](assets/test14.png)  | ![](assets/test15.png) |
# | MinimumError |  Moments | Niblack |
# | ![](assets/test16.png) | ![](assets/test17.png) | ![](assets/test18.png) |
# | Polysegment | Sauvola | UnimodalRosin |
# | ![](assets/test19.png) | ![](assets/test20.png) | ![](assets/test21.png) |
# | Intermodes | Otsu | Yen |
# | ![](assets/test22.png) | ![](assets/test23.png) | ![](assets/test24.png) |

# For every pixel, the same threshold value is applied. In some cases, if the pixel value is smaller 
# than the threshold, it is set to 0, otherwise it is set to a maximum value. In other algorithms,
# a complete opposite approach is used.

# Every algorithm has its own way of selecting that threshold and in some methods
# it can be defined.

# `binarize_methods()`` could be particularly useful when you are not aware of the 
# underlying assumptions made in algorithms and see all results and choose between them.