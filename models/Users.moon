import Model from require "lapis.db.model"

class Users extends Model
  @constraints: {
    -- digest cannot be checked here, passwords must be checked before they are converted to a digest

    name: (value) =>
      if not value or value\len! < 1
        return "You must enter a username."

      if value\len! > 255
        return "Usernames must be 255 or fewer characters in length."

      if value\find "%s"
        return "Usernames cannot contain spaces."

      if value\lower! == "admin"
        return "That username is unavailable."

      if Users\find name: value\lower!
        return "That username is unavailable."

    email: (value) =>
      if value
        if value\len! > 255
          return "Email addresses must be 255 or fewer characters in length."

        if value\find "%s"
          return "Email addresses cannot contain spaces."
  }
