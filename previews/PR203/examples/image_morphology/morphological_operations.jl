using Images, Noise, ImageMorphology
using HistogramThresholding
using MosaicViews, ImageDraw

function get_image(url)
    img = mktemp() do fn, f
        download(url, fn)
        load(fn)
    end
    img_resized = imresize(img, ratio = 1 / 2)
end

img_coins = get_image("https://i.imgur.com/91IOKtJ.png")

edges1, counts1 = build_histogram(Gray.(img_coins), 256)
t1 = find_threshold(UnimodalRosin(), counts1[1:end], edges1)
img_final_coins = zeros(Bool, axes(Gray.(img_coins)))
for i in CartesianIndices(img_coins)
    img_final_coins[i] = Gray.(img_coins[i]) < t1 ? 0 : 1
end
img_final_coins

Gray.(img_final_coins)

cordinates = convexhull(img_final_coins)
push!(cordinates, cordinates[1])
img_convex_hull = zeros(RGB, axes(Gray.(img_coins)))
draw!(img_convex_hull, Path(cordinates), RGB(1))
img_convex_hull

img_final_coins1 = salt_pepper(img_final_coins, 0.5)
fill_image_1 = imfill(img_final_coins1, (0.1, 1))
fill_image_2 = imfill(img_final_coins1, (0.1, 10)) # this configuration gets use the best results
fill_image_3 = imfill(img_final_coins1, (1, 10))
fill_image_4 = imfill(img_final_coins1, (5, 20))
Gray.([img_final_coins1 fill_image_1 fill_image_2 fill_image_3 fill_image_4])

img_thinning = thinning(img_final_coins, algo = GuoAlgo());
Gray.([img_final_coins img_thinning])

cleared_img_1 = clearborder(img_final_coins, 20); # 20 is the width of border that's examined
cleared_img_2 = clearborder(img_final_coins, 30); # notice how it remove the inner circle even if it's outside its range
cleared_img_3 = clearborder(img_final_coins, 30, 1);

Gray.([img_final_coins cleared_img_1 cleared_img_2 cleared_img_3])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

