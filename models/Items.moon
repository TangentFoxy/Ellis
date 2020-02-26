import Model from require "lapis.db.model"

sign = (n) ->
  if n < 0
    return -1
  if n == 0
    return 0
  return 1

class Items extends Model
  @create: (values, opts) =>
    if not values.score
      values.score = 0
    if not values.time
      values.time = (os.time(os.date("!*t")) - 1.5e9) / 1e5
    values.sort = values.time + sign(values.score) * math.log(math.max(0.999, values.score^2))
    super values, opts

  update: (values) => -- NOTE technically breaks Model specs, see https://github.com/leafo/lapis/blob/master/lapis/db/postgres/model.moon#L70
    score = values.score or @score
    time = values.time or @time
    values.sort = time + sign(score) * math.log(math.max(0.999, score^2))
    super values
