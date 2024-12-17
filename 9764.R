# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path)

# 將數字轉為 0，保留文字，並保持第一列不受影響
processed_data <- data |>
  dplyr::mutate(across(everything(), ~ ifelse(is.numeric(.x), 0, .x))) |>
  dplyr::slice(1) |>
  dplyr::bind_rows(dplyr::select(data, everything()))

# 儲存處理後的資料為新檔案
output_path <- "processed2_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

# 確認完成
print(paste("處理後的資料已儲存為", output_path))
