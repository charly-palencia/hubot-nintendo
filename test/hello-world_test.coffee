path = require "path"
chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = require('chai').expect
helper = require 'hubot-mock-adapter-helper'
TextMessage= require("hubot/src/message").TextMessage


describe 'search nintendo games', ->
  {robot, user, adapter} = {}

  beforeEach (done)->
    helper.setupRobot (ret) ->
      {robot, user, adapter} = ret
      require('../src/hello-world')(robot)
      do done

  afterEach ->
    robot.shutdown()

  describe "search game", ->

    it "successful response", (done)->
      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0].length).to.equal(39)
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot search game mario"))

    it "empty response", (done)->

      adapter.on "reply", (envelop, strings) ->
        try
          expect(strings[0]).to.equal("I didn't find any games for you")
          done()

        catch e
          done e

      adapter.receive(new TextMessage(user, "hubot search game asdajwXBOX"))


