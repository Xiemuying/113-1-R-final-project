# 讀取原始 CSV 檔案
file_path <- "台南市各行各業所犯罪刑(一整年).csv"
data <- readr::read_csv(file_path)

# 定義函數：將可以轉為數字的資料轉換為 0，其他保持不變
convert_to_zero <- function(x) {
  if (is.na(as.numeric(x))) {
    # 若轉換數字失敗，保持原值
    return(x)
  } else {
    # 若成功轉換為數字，返回 0
    return(0)
  }
}

# 對所有資料進行處理，保留第一列原樣
processed_data <- data
processed_data[-1, ] <- processed_data[-1, ] |>
  dplyr::mutate(across(everything(), ~ sapply(.x, convert_to_zero)))

# 儲存處理後的資料為新檔案
output_path <- "processed_台南市各行各業所犯罪刑.csv"
readr::write_csv(processed_data, output_path)

# 確認完成
print(paste("處理後的資料已儲存為", output_path))
