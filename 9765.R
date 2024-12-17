# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path)

# 定義函數，將數字轉為 0，保留文字
convert_to_zero <- function(x) {
  if (is.numeric(x)) {
    return(0)
  } else {
    return(x)
  }
}

# 保留第一行原樣，對其餘行處理數字
processed_data <- data
processed_data[-1, ] <- data[-1, ] |>
  dplyr::mutate(across(everything(), ~ ifelse(is.na(as.numeric(.x)), .x, 0)))

# 儲存處理後的資料為新檔案
output_path <- "processed3_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

# 確認完成
print(paste("處理後的資料已儲存為", output_path))
