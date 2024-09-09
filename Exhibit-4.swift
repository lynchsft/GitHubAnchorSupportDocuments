struct WorkflowConstructionYard {
    var workflow: Workflow {
        .init(
            name: "Precompile and Commit Executable",
            on: "workflow_dispatch: {}",
            defaults: """
                      run:
                        shell: bash
                      """,
            jobs: [
                "build": .init(
                    runsOn: #"[self-hosted, "${{ matrix.os }}" ]"#,
                    steps:
                        generateAppToken,
                        checkout,
                        grantGitHubAccess,
                        setOSString,
                        buildSwiftPackageMacLinux,
                        moveExecutableToBin,
                        commitExecutableViaLFS,
                    strategy: """
                              matrix:
                                os: [macOS]
                              """
                )
            ]
        )
    }
    
    @AnchorNamed
    var gh_app_token: String {
        generateAppToken.outputs[.token]
    }
    
    @AnchorNamed
    var gh_org: String {
        "${{ github.repository_owner }}"
    }
    
    var generateAppToken: ActionStep<CreateGithubAppToken_v1> {
        .init(with: .appId("${{ vars.CREATE_GITHUB_APP_TOKEN_APP_ID }}"),
                    .privateKey("${{ secrets.CREATE_GITHUB_APP_TOKEN_PRIVATE_KEY }}"),
                    .owner(gh_org)
        )
    }
    
    var checkout: ActionStep<Checkout_v4> {
        .init(with: .token(gh_app_token),
                    .ref("${{ github.head_ref }}"),
                    .persistCredentials(false)
                    // ^ Make sure the value of GITHUB_TOKEN will not be persisted in repo's config
        )
    }
    
    
    var grantGitHubAccess: ActionStep<GithubAccessAction_v3> {
        .init(with: .actionTargetOrg(gh_org),
                    .appAccessToken(gh_app_token)
        )
    }
    
    
    @AnchorNamed
    var setOSString: Step {
     """
     run: |
       OS=${{ matrix.os }}
       if [[ $OS == "winbuild-gh" ]];
            then OS=Windows
       fi
       echo OSDIR=$OS >> $GITHUB_ENV
     """
    }
    
    @AnchorNamed
    var buildSwiftPackageMacLinux: Step {
     """
     name: Build Swift Package (Mac/Linux)
     if: runner.os != 'Windows'
     run: |
       swift build --scratch-path bin
     """
    }
    
    @AnchorNamed
    var moveExecutableToBin: Step {
        """
        run: |
          BINDIR=$(swift build --scratch-path bin --show-bin-path)
          echo $BINDIR
          SOURCEDIR=${BINDIR}/fossa-action
          echo $SOURCEDIR
          DESTDIR=${BINDIR%bin/*}bin/$OSDIR/fossa-action
          echo $DESTDIR
          mv $SOURCEDIR $DESTDIR
        """
    }
    
    @AnchorNamed
    var commitExecutableViaLFS: Step {
        """
        run: |
          git lfs install
          git add bin/$OSDIR/fossa-action
          git commit -m "Commit Executables"
          git push origin ${{ github.ref_name }}
        """
    }
    
}