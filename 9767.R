# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path)

# 將數字轉為 0，其他保持不變
convert_to_zero <- function(column) {
  dplyr::case_when(
    !is.na(as.numeric(column)) ~ 0,  # 如果是數字，轉為 0
    TRUE ~ column                # 其他保留原值
  )
}

# 保留第一列，對其餘行進行處理
processed_data <- data
processed_data[-1, ] <- data[-1, ] |>
  dplyr::mutate(across(everything(), convert_to_zero))

# 儲存處理後的資料
output_path <- "processed5_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

# 確認完成
print(paste("處理後的資料已儲存為", output_path))
