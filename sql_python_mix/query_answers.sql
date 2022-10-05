

with source1 as(
    select * from provider
)

,source2 as(
    select * from profession
)

,source3 as(
    select * from provider_practice
)

,source4 as(
    select * from provider_profession
)

,cte_provider_names as(
    select 
        replace(source1.provider_name, 'John', 'Johnathan') AS provider_name 
    from source1
    order by provider_name
)

,calculate_degree_count as(
    select distinct profession_degree, 
    cast(count(*) over(partition by profession_degree) as varchar(50)) as degree_count
    from source4
    left join source2
    on source4.profession_id = source2.profession_id
)

,cte_popular_degree as(
    select profession_degree,
        case
            when degree_count > '2' then 'popular degree'
            else degree_count
        end as degree_count
    from calculate_degree_count
)

,source_combined1 as(
    select *
    from provider_practice
    join provider_profession
    on provider_practice.provider_id = provider_profession.provider_id 
    join profession
    on profession.profession_id = provider_profession.profession_id
)
,calculate_provider_degree_city as (
    select city,count(*)
    from source_combined1
    where profession_degree = 'DO'
    and city ilike '%er%'
    group by 1
)

,source_combined2 as(
    select provider.provider_id,created,profession_id,city
    from provider 
    join provider_profession 
    on provider.provider_id = provider_profession .provider_id 
    join provider_practice
    on provider_practice.provider_id = provider_profession.provider_id 
)

, cte_provider_profession_after_april as (
    select provider_id, profession_id,created,city
    from source_combined2
    where created > '2010-04-30 23:59:59'
    AND city ~ '\s'
)

,cte_provider_live_place as(
    select provider_name,city
    from source1 
    join source3 using(provider_id)
    where city = 'Rutherford'
)

,question1_answer as(
    select * from cte_provider_names
)
    
,question2_answer as(
    select * from cte_popular_degree
)
    
,question3_answer as(
    select * from calculate_provider_degree_city
)
    
,question4_answer as(
    select * from cte_provider_profession_after_april
)

,question6_answer as(
    select * from cte_provider_live_place
)

,final as(
    select * from question?
)

select * from final