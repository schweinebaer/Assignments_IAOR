# Figure 1 - initial image
# Figure 2 - grayscaled image
# Figure 3 - grayscaled histogram
# Figure 4 - streched grayscaled histogram
# Figure 5 - streched grayscaled image

# EXTERNAL PACKAGE USED:
# install image package for histogram display
pkg install -forge image
pkg load image


# load image
img_color = imread('input_sat_image.jpeg');

# seperate into red green blue matrix
img_red = img_color(:,:,1);
img_green = img_color(:,:,2);
img_blue = img_color(:,:,3);

# store width (N) and heigjt (M)
[M, N, ~] = size(img_color);

# create zero-matrix with size MxN
img_gray = zeros(M, N, 'uint8');

# grayscale img by using 0.2989 weight for red, 0.5870 weight for green and 0.114 weight for blue (found values online)
for i = 1:M
  for j = 1:N
    img_gray(i, j) = (img_red(i, j)*0.2989)+(img_green(i, j)*0.5870)+(img_blue(i, j)*0.114);
  end
end


# display colored image in figure 1 and gray image in figure 2
figure(1); imshow(img_color);
figure(2); imshow(img_gray);

# display histogram of grayed image in figure 3
figure(3); imhist(img_gray);

# store min and max values of img_gray
min = uint8(min(min(img_gray)));
max = uint8(max(max(img_gray)));

#{
interpretation:

  691 px height
  1048 px width
  (now only one matrix due to grayscale; before there were 3 matrixes)

  intensity range is between 145 and 226
  with an peek at intensity value 164 of around 45.000 pixels
  the range is mostly in the upper half of the 0-255 range which results in an more bright image

#}

# contrast stretching
img_gray_streched = zeros(M, N, 'uint8');
for i = 1:M
  for j = 1:N
    img_gray_streched(i, j) = (double(img_gray(i, j) - min)) / double((max - min)) * 255;
  end
end

# display histogram of streched greyed image in figure 4
figure(4); imhist(img_gray_streched);

#{
interpretation:

  intensity range streched from 0 to 255
  still low values till intensity value of around 30 and after 220.
  could be solved by treshhold. (see next task)
  values equaly distributed over whole range with a smaller shift into dark (low) values.
  peek value also at the dark area now around a 60. (before 164)

#}

# display enhanced image in figure 5
figure(5); imshow(img_gray_streched);



