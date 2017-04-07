view: food_journal_workshop {
  sql_table_name: analytics.food_journal ;;

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
    hidden: yes
  }

  dimension_group: wwdate {
    label: "Food Entry"
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
  dimension: smartpoints {
    type: number
    sql: ${TABLE}.smartpoints ;;
  }
  measure: total_smartpoints {
    type: sum
    sql: ${smartpoints} ;;
    group_label: "Points"
  }

  measure: average_smartpoints {
    type: average
    sql: ${smartpoints} ;;
    group_label: "Points"
  }

  measure: min_smartpoints {
    type: min
    sql: ${smartpoints} ;;
    group_label: "Points"
  }

  measure: max_smartpoints {
    type: max
    sql: ${smartpoints} ;;
    group_label: "Points"
  }
  dimension: itemid {
    type: string
    sql: ${TABLE}.itemid ;;
    group_label: "Item"
  }

  measure: meal_items_count {
    type:  count_distinct
    sql:  ${itemid} ;;
    group_label: "Item"
  }


}
