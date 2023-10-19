# Основы архитектуры GP

Основное:
1. Кластер имеет мастер, у мастера всегда есть реплика
2. Остальные серверы выделяются под сегменты, на одном хосте (сервере) может быть несколько сегментов (например, 2 как у нас в облаке ниже)
3. Каждый сегмент всегда имеет зеркало, сегмент и его зеркало всегда находятся на разных хостах - отказоустойчивость
4. Данные обрабатываются только на первичных сегментах


![external-load.png](..%2Fimg%2Fexternal-load.png)

Загрузка/выгрузка из внешних источников может осуществлятся через сегменты -> параллельность и увеличение произволительностию.
За это отвечаeт инструмент PXF:
1. [intro_pxf от VMWare](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.7/greenplum-platform-extension-framework/intro_pxf.html)
2. [Использование внешних таблиц от YandexCloud](https://cloud.yandex.ru/docs/managed-greenplum/operations/external-tables)

------------------------------
# Задание

![practice-1.png](..%2Fimg%2Fpractice-1.png)

1. Run Managed Service for GreenPlum

![cloud-gp-cluster-alive.png](..%2Fimg%2Fcloud-gp-cluster-alive.png)