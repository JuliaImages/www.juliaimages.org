# ---
# cover: assets/binarize.gif
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

using Images, ImageBinarization, TestImages, MosaicViews

function get_image(url)
    img = mktemp() do fn, f
        download(url, fn)
        load(fn)
    end
    img_resized = imresize(img, ratio = 1 / 2)
end

img = get_image("https://i.imgur.com/DDLL6tp.png");
img_gray = Gray.(img);

# Now let's binarize a image using Otsu algorithm

alg = Otsu()
img_otsu = binarize(img, alg)
[img img_gray img_otsu]

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
function binarize_methods(img, algs)
    imgs_binarized = Array[]
    for i in algs
        alg = getfield(ImageBinarization, Symbol(i))()
        img = binarize(img, alg)
        push!(imgs_binarized, img)
    end
    return imgs_binarized
end

output = binarize_methods(img, algs)
mosaicview(output, nrow = 3, npad = 1)



