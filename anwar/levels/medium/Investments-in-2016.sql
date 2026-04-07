select pid from Insurance i where tiv_2015 = (
    select tiv_2015 from Insurance where i.lat <> Insurance.lat and i.lon <> Insurance.lon limit 1
)
