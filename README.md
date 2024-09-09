#GitHub YAML Anchor Support#

* Current status of [#1182](https://docs.github.com/en/rest/using-the-rest-api/libraries-for-the-rest-api?apiVersion=2022-11-28). 
    * Feature Scheduled?
* Shared actions are a stand-in that work in lots of circumstances. 
    * But shared actions don’t share context with the Workspace they are called from. 
        * Shared actions require lots of inputs to provide the missing context.
            * These Inputs take up a lot of visual space and are error-prone repetitions. 
* Anchors complete the YAML-code reusability story. 
    * Anchors fully share the context of the Workflow, with zero introduced security concerns. 
    * Anchors enable automatic redundancy aliasing, identifying duplicated structures in a workflow.
        * Automatically created aliases are an invitation to name repeated portions of code.
            * Named portions of code complete the notion of “programming” workflows. 
                * The Gödel-Turing semantic jump enables higher-order programming techniques. 
        * Redundancy aliasing reduces the total size of the workflow and eliminates sources of error during maintenance. 
        * Redundancy aliasing provides a one-line cost for step injections (after the first definition)
            * Example: a security regime injects an evidence-collecting script after every _natural_ step of a workflow. 
    * By enabling anchor support GitHub will foster a collection of open-source tools providing high-order programming semantics for Workflows.
        * This echo system is akin to the [list of public libraries for the GitHub REST API](https://docs.github.com/en/rest/using-the-rest-api/libraries-for-the-rest-api?apiVersion=2022-11-28)
* Ok, so what happens if GitHub does _not_ enable anchor support?
    * Omnissa will proceed to enjoy the above advantages of anchors and maintain two forms of workflows:
        * The authoritative, minimized, anchor annotated form 
            * GitHub will raise errors on these files as having invalid syntax.
        * The derived, expanded, anchor-less form
            * GitHub will accept these files and act on them. 
* Invitation:
    * Omnissa is investing in yaml anchors and high-order Workflow programming.
    * Partner with us. 
        * Turn on yaml anchor support for our enterprise or for a limited number of repositories in our enterprise.
        * Receive updates on our findings, our frictions, our results. 
        * Learn what your strong partner Omnissa can do with best-in-class Workflow programming techniques. 


##Exhibits:##
1. [A typical workflow (starting point)](Exhibit-1.yaml)
2. [The workflow with Auto Aliasing enabled](Exhibit-2.yaml)
3. [The workflow with named anchors/aliases](Exhibit-3.yaml)
4. [A programmable context with named aliases](Exhibit-4.swift)
5. [A fully expanded form of the workflow with an injected (AOP) security control to report build evidence](Exhibit-5.yaml) 
6. [A minimized form of the workflow with an injected (AOP) security control to report build evidence](Exhibit-6.yaml)

##Links:##
* [Public feature request for GitHub yaml parsing to support anchors](https://github.com/actions/runner/issues/1182)
* [GitHub listing of public libraries for the REST API](https://docs.github.com/en/rest/using-the-rest-api/libraries-for-the-rest-api?apiVersion=2022-11-28)
