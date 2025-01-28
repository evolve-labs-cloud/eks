TO DOS:

- create fargate profile
- create fargate access_entry
- create new security for fargate profile
- use helm metric server just in EC2 mode, because it can be health in fargate.
- there are some problems with coredns because of fargate, we need a lambda that reset the service
