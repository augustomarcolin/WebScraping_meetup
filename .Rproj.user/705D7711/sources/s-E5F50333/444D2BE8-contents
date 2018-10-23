library(RSelenium)
library(rvest)

# abrindo a conexão

driver  <- rsDriver(browser = c('chrome'))

remDr <- driver[['client']]

remDr$navigate("https://trends.google.com.br/trends/?geo=BR")

# pesquisando o termo e clicando enter 

termo <- "roger waters"

search_box <- remDr$findElement(using = 'xpath', '//*[@id="input-254"]')

search_box$sendKeysToElement(list(termo, "\uE007"))
  
Sys.sleep(3)

# baixanado os dados

download_button <- remDr$findElement(using = 'xpath', '/html/body/div[2]/div[2]/div/md-content/div/div/div[1]/trends-widget/ng-include/widget/div/div/div/widget-actions/div/button[1]')

download_button$clickElement()
