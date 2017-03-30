view: food_journal_workshop {
  sql_table_name: analytics.food_journal ;;

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
    hidden: yes
  }

  dimension_group: wwdate {
    label: "Food Entry test"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.wwdate ;;
  }

  dimension: timeclassifier {
    label: "Time of Day test"
    type: string
    sql: ${TABLE}.timeclassifier ;;
  }
  measure: user_meal_count {
    description: "Count Of Unique Meals Tracked"
    type: count_distinct
    sql: ${userid} ;;
  }
}
