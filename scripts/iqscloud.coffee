module.exports = (robot) ->

      robot.respond /iqs run (.*)/i, (rep) ->
        tag = rep.match[1]
        rep.reply "OK, running the testset tagged with " + tag + " in iqs\nI'll report back the results when done."
        encTag = 
        robot.http("https://iqscloud.infraxis.com/IQScloudWeb/IQScloudManager/api?token=8zf0bb1ue0qkk8x0&tag=#{tag}")
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          # error checking code here
          if rep.statusCode isnt 200
            rep.send "Hmm, that didn't work out - #{err}"
            return
          data = JSON.parse body
          rep.send "OK, iqs has finished testset #{tag}\n
                  passed : #{data.passed}\n
                  failed : #{data.failed}\n
                  aborted: #{data.aborted}"
                  
