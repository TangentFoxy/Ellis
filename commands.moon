lapis = require "lapis"
config = require("lapis.config").get!
bcrypt = require "bcrypt"

import Items, OrphanItems, Tags, ItemTags, Users from require "models"
import respond_to, json_params from require "lapis.application"
import trim from require "lapis.util"

split = (str) ->
  tab = {}
  for word in str\gmatch "%S+"
    table.insert(tab, word)
  return tab

patterns = { "^@.+", "^%+.+", "^#.+", "^([^:]+:).+" }
find_tags = (tab) ->
  tags = {}
  for word in *tab
    for pattern in *patterns
      tag = word\match pattern
      if tag and tag\len! > 0
        table.insert tags, tag
        break
  return tags

commands = {
  account: (args) =>
    switch table.remove(args, 1)\lower!
      when "create"
        if #args < 2
          return nil, "You must specify a password."
        @action = string.gsub "Welcome #{args[1]}!", "]", "\\]"
        response, err = Users\create {
          name: args[1]
          digest: bcrypt.digest(args[2], config.digest_rounds)
          email: args[3]
        }
        @session.id = response.id if response
        return response, err
      when "login"
        if #args < 2
          return nil, "You must enter your username and password."
        if @user = Users\find name: args[1]
          if bcrypt.verify args[2], @user.digest
            @session.id = @user.id
            welcome = string.gsub "Welcome #{@user.name}!", "]", "\\]"
            return welcome
        return nil, "Invalid username or password."
      when "logout"
        @action = "You are logged out."
        @session.id = nil
      else
        nil, "Invalid command."

  add: (args) =>
    if not @user
      return nil, "You must be logged in to do that."

    errs = {}
    text = ""
    if #args > 0
      text = table.concat args, " "
    if @params.input and @params.input\len! > 0
      text ..= "\n\n#{@params.input}"
      args = split text -- re-generate full arguments when needed
    text = trim text
    tags = find_tags args

    item, err = Items\create {
      user_id: @user.id
      :text
    }
    if err
      table.insert errs, err
    if item
      if #tags < 1
        orphan, err = OrphanItems\create { item_id: item.id }
        if err
          table.insert errs, err
      else
        for text in *tags
          tag = Tags\find match: text
          if tag
            _, err = tag\update score: tag.score + 1
          else
            tag, err = Tags\create user_id: @user.id, match: text, score: 1
            if err
              table.insert errs, err
          if tag
            item_tag, err = ItemTags\create tag_id: tag.id, item_id: item.id
            if err
              table.insert errs, err
    if #errs > 0
      return nil, "Error(s) occurred:\n#{table.concat errs, "\n"}"
    else
      return "Item added."
}

class extends lapis.Application
  @path: "/command"

  [command: ""]: respond_to {
    GET: =>
      return layout: false, status: 405, "Method not allowed."
    POST: json_params =>
      args = split(@params.command)
      command = string.lower table.remove args, 1

      if @session.id
        @user = Users\find id: @session.id

      output = {}

      if commands[command]
        response, err = commands[command](@, args)
        if err
          table.insert(output, "[[;red;]#{err\gsub "]", "\\]"}]")
        elseif @action
          table.insert(output, @action)
        elseif response
          table.insert(output, response)
      else
        table.insert(output, "[[;red;]Unknown command.]")

      return layout: false, table.concat output, "\n"
  }
