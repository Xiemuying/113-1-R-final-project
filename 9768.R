# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path, col_types = cols(.default = "c")) # 強制所有欄位讀為文字型

# 定義函數：將數字轉為 0，其他保留原值
convert_to_zero <- function(value) {
  if (!is.na(as.numeric(value))) {
    return("0") # 將數值或數字型字串轉為文字型的 "0"
  } else {
    return(value) # 其他保留原值
  }
}

# 保留第一行不變，對其餘行進行處理
processed_data <- data
processed_data[-1, ] <- processed_data[-1, ] |>
  dplyr::mutate(across(everything(), ~ sapply(.x, convert_to_zero)))

# 儲存處理後的資料
output_path <- "processed6_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

# 確認完成
print(paste("處理後的資料已儲存為", output_path))
