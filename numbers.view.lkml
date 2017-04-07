view: numbers {

  derived_table: {
    sql: SELECT
      ROW_NUMBER() OVER () as index
    FROM
         (SELECT 0 as n UNION SELECT 1) p0,
         (SELECT 0 as n UNION SELECT 1) p1,
         (SELECT 0 as n UNION SELECT 1) p2,
         (SELECT 0 as n UNION SELECT 1) p3,
        (SELECT 0 as n UNION SELECT 1) p4,
        (SELECT 0 as n UNION SELECT 1) p5,
        (SELECT 0 as n UNION SELECT 1) p6,
        (SELECT 0 as n UNION SELECT 1) p7,
         (SELECT 0 as n UNION SELECT 1) p8,
         (SELECT 0 as n UNION SELECT 1) p9,
         (SELECT 0 as n UNION SELECT 1) p10,
        (SELECT 0 as n UNION SELECT 1) p11,
        (SELECT 0 as n UNION SELECT 1) p12
      ;;
   sortkeys: ["index"]
   distribution: "index"
   sql_trigger_value: SELECT COUNT(*) ;;
  }

  dimension: index {
    description: "Use this for counting lifetime orders across many users"
    type: number
    sql: ${TABLE}.index ;;
  }
}
