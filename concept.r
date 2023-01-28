

***********
EventBridge
***********
        - EventBridge is a serverless service that uses events to connect application components together, making it
          easier for you to build scalable event-driven applications
        - Use it to route events from sources such as home-grown applications, AWS services, and third- party
          software to consumer applications across your organization
        - EventBridge provides a simple and consistent way to ingest, filter, transform, and deliver events so you
          can build new applications quickly
        - EventBridge event buses are well suited for many-to-many routing of events between event-driven services
        - EventBridge Pipes is intended for point-to-point integrations between these sources and targets, with
          support for advanced transformations and enrichment
          *********
          Event Bus
          *********
            - An event bus is a pipeline that receives events
            - Rules associated with the event bus evaluate events as they arrive
            - Each rule checks whether an event matches the rules criteria
            - You associate a rule with a specific event bus, so the rule only applies to events received by that event bus