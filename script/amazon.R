library(rvest)
library(RSelenium)
library(dplyr)

# abrindo navegacao

driver  <- rsDriver(browser = c('chrome'))

remDr <- driver[['client']]

remDr$navigate("https://www.amazon.com.br/")



#----- seções de pesquisa

# data frame com as opções

options <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes("option") %>%
  html_text()

option_values <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes("option") %>%
  html_attr("value")

option_df <- data.frame(
  option = options,
  value = as.character(option_values)
)

# clicando nas secoes

section_button <- remDr$findElement(using = 'xpath', '//*[@id="searchDropdownBox"]')

section$clickElement()

choose <- remDr$findElement(using = 'xpath', sprintf("//*/option[@value = '%s']",
                                                   option_df[12,2]))

choose$clickElement()

#----- buscando o item na seção

search_box <- remDr$findElement(using = 'xpath', '//*[@id="twotabsearchtextbox"]')

txt_search <- "revolução dos bichos"

search_box$sendKeysToElement(list(value = txt_search))

# clicando na pesquisa

search_button <- remDr$findElement(using = 'xpath', '//*[@id="nav-search"]/form/div[2]/div/input')

search_button$clickElement()

#------ Pegando os preços e títulos

# titulos
names_nodes <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(".a-size-medium.a-color-base") 

names_values <- names_nodes[html_attr(names_nodes , "class") == "a-size-medium a-color-base"] %>%
  html_text()

# preços
values_nodes <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(".sg-col-inner") %>%
  html_nodes('.a-price')

actual_price <- values_nodes[html_attr(values_nodes, "data-a-size") == "l"] %>%
  html_nodes(".a-offscreen") %>%
  html_text()

last_price <- values_nodes[html_attr(values_nodes, "data-a-size") == "b"] %>%
  html_nodes(".a-offscreen") %>%
  html_text()


df_prices <- data.frame(
  produto = names_values,
  preco_atual = actual_price,
  preco_antigo = last_price
)
