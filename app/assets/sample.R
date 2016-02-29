image_path = "/Users/awells/Desktop/Dixon Lab/websites/commandsapp/app/assets/images/sample.png"
numbers <- c(12,34,56,20,44,65)
png(filename=image_path)
plot(numbers)
dev.off()