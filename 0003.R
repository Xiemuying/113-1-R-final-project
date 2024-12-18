# 讀取檔案，強制所有欄位讀為文字型
file_all <- "台南市各行各業所犯罪刑(一整年).csv"
file_half <- "台南市各行各業所犯罪刑(一到六月).csv"

data_all <- readr::read_csv(file_all, col_types = cols(.default = "c"))
data_half <- readr::read_csv(file_half, col_types = cols(.default = "c"))

# 定義減法邏輯，並保留原始文字
subtract_values <- function(value1, value2) {
  num1 <- suppressWarnings(as.numeric(value1))
  num2 <- suppressWarnings(as.numeric(value2))
  
  if (!is.na(num1) && !is.na(num2)) {
    return(as.character(num1 - num2))
  } else {
    return(value1)
  }
}

# 處理資料，保留欄位名稱和第一列
result_data <- data_all
result_data[-1, ] <- purrr::map2_dfr(
  data_all[-1, ],
  data_half[-1, ],
  ~ purrr::map2_chr(.x, .y, subtract_values)
)

# 儲存結果
output_path <- "台南市各行各業所犯罪刑(差異結果2).csv"
readr::write_csv(result_data, output_path)

# 確認處理完成
print(paste("處理後的結果已儲存為", output_path))
