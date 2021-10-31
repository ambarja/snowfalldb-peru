library(tidyverse)
library(ggplot2)
data <- read_csv('csv/snowfallDB-Peru.csv',locale = readr::locale(encoding = "UTF-8")) %>% 
  separate(Fecha,into = c('anio','mes','dia')) %>% 
  select(Dep,anio,mes,Afectado) %>% 
  group_by(Dep,mes,Afectado) %>% 
  summarise(Afectado = sum(Afectado,na.rm = T)) %>% 
  filter(Dep %in% c('APURIMAC','AREQUIPA','AYACUCHO','CUSCO',
                   'HUANCAVELICA','PUNO'))

data %>% 
  ggplot(aes(x = mes,y = log(Afectado+1))) + 
  geom_bar(stat = 'identity') + 
  coord_polar() + 
  facet_wrap(Dep ~.)

