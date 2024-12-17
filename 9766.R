# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path)

# 定義函數，將數字轉為 0，保留文字
convert_to_zero <- function(x) {
  ifelse(!is.na(as.numeric(x)) & !is.character(x), 0, x)
}

# 將資料逐一處理，保留第一列原樣
processed_data <- data
processed_data[-1, ] <- processed_data[-1, ] |>
  dplyr::mutate(across(everything(), ~ convert_to_zero(.x)))

# 確認完成
# 儲存處理後的資料為新檔案
output_path <- "processed4_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

print(paste("處理後的資料已儲存為", output_path))
