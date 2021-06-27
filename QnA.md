### How long did this assignment take?
> 5 days, working a few hours a day, focused on delivering good code and testing coverage to avoid regressions when adding new features and not add more stuff that it needed.

### What was the hardest part?
> Working on the Authorization layer without some code reviews of the coworkers to get some posible insights about failures points that I don't see working in this simple solution.


### Did you learn anything new?
> We always learning a anything in the development process, in this project I've learn:
  - How to matches a params `(:email)` in the url of the request with regex in the rails router layer, in the rails world we always use some `id` in the url.
  - A simple configuration on Active Model Serializer to returns the object model as root key in the payload.
  - A bit more about JWT
  - a bit more about cookies and localStorate.
  - A bit more about Curl requests

### Is there anything you would have liked to implement but didn't have the time to?
> No, I believe that managed to implemented all requirements using simple solutions, I'd lovely if I can have some feedback from the team about improvements or diferente approachs to resolve the problem.
for example how to improves the tests about JWT encode and decode.

### What are the security holes (if any) in your system? If there are any, how would you fix them?
> I'm concern about if someone has access of the jwt token about one user, this person will be able to make a http request and get some information back, but is a concern that need to be aligned with the frontend team the best and safe approach to store this token in the client side.
- Using cookie we can have the possibility to suffer some CSRF attack, but cookies we need always use https to encrypt the request.
- Using localStorage some issue about

### Do you feel that your skills were well tested?
> More os less, I believe that developers skills are more than just code, for example
how to design new solutions in the architecture existent, how to integrates the application with an existent application in production, how to analysis a new problem and creates a proposal of a solution, communication with stakeholders, engajament with the the team to help others coworkers, participating actively in code reviews to help the team deliver good features.

### Future implementations, just thinking loud.
- Improve the friendship features, we can add invitations, approves, declines, removes a frienship, depends of the concept of the friendship feature, we can handle with the approach like twitter you can followw someone else with open profile, or ask for follow and need to be accepted.
- Align with the frontend team a better solution how to store the JWT token to be used.
- Background jobs for future features that can be asynchronous to avoid overcharge of endpoints and improves the latency of response with the ideia that this project will be growth in some years, using a sidekiq job or a message broker like RabbitMQ.
- Improves the pagination feature, maybe use `kaminary` to deliver a better experience for the frontend like total_pages, current_pag, next_page, prev_page, first_page?, last_page?.
- Add CI/CD to the project
- Improves the DockerFile and docker-compose to be able to create a new instance easier to scale the application or make the setup easier for other developers.
- Improves the Authentication Layer.
- Add some permission layers like admin, user.
- Automate the deploy
- Add a log tool like Logentries to be able to see the behaviour of the application in production environment.
- Add a monitoring tool like New Relic to improves tha analysis of the application to take some action about some issue.
- Add a telemetry events
- Tool to capture errors like Sentry or bugsnag.
- For future implementations we can start to think about isolate the business logic inside of a services layer.
- Add some Cache layer on the API, Redis can be a good candidate
- Add some rate limit for request from the same API to avoid sequentials requests can be possible crawled to get our data.
- Use devise to user model, brings good features with like, reset password, confirmation account, etc.
