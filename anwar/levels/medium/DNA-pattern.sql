select sample_id , dna_sequence , species , 
case
 when dna_sequence ~ '^ATG' then 1
 ELSE 0
end as "has_start",
case 
    when dna_sequence ~ '(TAA|TAG|TGA)$' then 1
    else 0
end as "has_stop",
case 
    when dna_sequence ~ 'ATAT' then 1
    else 0
end as "has_atat",
case
    when dna_sequence ~ 'G{3}' then 1
    else 0
end as "has_ggg"
from Samples
