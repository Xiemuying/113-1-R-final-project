# 讀取兩個檔案，強制所有欄位讀取為文字型
file_all <- "台南市各行各業所犯罪刑(一整年).csv"
file_half <- "台南市各行各業所犯罪刑(一到六月).csv"

data_all <- readr::read_csv(file_all, col_types = cols(.default = "c"))
data_half <- readr::read_csv(file_half, col_types = cols(.default = "c"))

# 定義函數：處理兩個值之間的運算
subtract_values <- function(value1, value2) {
  num1 <- as.numeric(value1)
  num2 <- as.numeric(value2)
  
  if (!is.na(num1) && !is.na(num2)) {
    # 若兩個值均為數字，進行相減
    return(as.character(num1 - num2))
  } else {
    # 否則保持原值（文字不變）
    return(value1)
  }
}
warnings() 我請chatgpt指出錯誤在哪


# 保留第一行不變，對其餘行進行逐格運算
result_data <- data_all
result_data[-1, ] <- purrr::map2_dfr(
  data_all[-1, ],
  data_half[-1, ],
  ~ purrr::map2_chr(.x, .y, subtract_values)
)

# 儲存處理後的資料
output_path <- "台南市各行各業所犯罪刑(差異結果1).csv"
readr::write_csv(result_data, output_path)

# 確認完成
print(paste("處理後的結果已儲存為", output_path))
