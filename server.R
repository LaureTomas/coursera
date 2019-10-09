library(shiny)

shinyServer(function(input, output) {

    output$cell_types_ui <- renderUI({
        cells <- input$cell_types
        cells <- gsub(" ","", cells)
        cells_ok <- unlist(strsplit(cells,","))
        print(cells_ok)
        fieldsAll <<- c("mark_name", "cell_types","genome","release","mark_type")
        for (i in cells_ok)
        {
            fieldsAll <<- c(fieldsAll,paste0("donors_",i)
                            ,paste0("rep_",i)
                            # ,paste0("end_chip_",i)
                            ,paste0("input_",i)
                            # ,paste0("end_input_",i)
            )
        }
        tagList(lapply(cells_ok, function(i){
            print(i)
            tagList(
                textInput(inputId = paste0("donors_",i),label = HTML(paste("<span style='color:#13BED2'>Donors | Tissues For ",i,"</span>")),value = "")
                , textInput(inputId = paste0("rep_",i),label = HTML(paste("<span style='color:#D600FF'>Replicates of Chips For each Donor of ",i,"</span>")),value = "")
                , textInput(inputId = paste0("input_",i),label = HTML(paste("<span style='color:#AA00CB'>Replicates of Inputs For each Donor of ",i,"</span>")),value = "")

            )
        }))
    })

    datasetInput <- reactive({
        inputs_to_save <- fieldsAll
        inputs <- NULL
        for(input.i in inputs_to_save){
            inputs <- append(inputs, input[[input.i]])
        }
        inputs_data_frame <- data.frame(inputId = inputs_to_save, value = inputs)
        inputs_data_frame <- as.data.frame(apply(inputs_data_frame, 2, function(x) gsub(" ","",x)))
    })
    
    output$downloadData <- downloadHandler(
        
        # This function returns a string which tells the client
        # browser what name to use when saving the file.
        filename = function() {
            paste0(input$mark_name,"_chipseq_parameters_",format(Sys.time(), "%b_%d_%Y"),".txt")
        },
        
        # This function should write data to a file given to it by
        # the argument 'file'.
        content = function(file) {
            
            # Write to a file specified by the 'file' argument
            write.table(datasetInput(), file, row.names = FALSE,quote = F,sep = "\t", col.names = F)
        }
    )

    output$HelpBox = renderUI({
        if (input$action %% 2){
            HTML("This Shiny Form's purpose is create a Parameter File for the automatized ChIP-seq Pipeline: <br/>
                         Several item should be provided: <br/>
                          &nbsp &nbsp &nbsp &nbsp - Name of the ChIP <br/>
                          &nbsp &nbsp &nbsp &nbsp - Signal Type: Broad or Narrow <br/>
                          &nbsp &nbsp &nbsp &nbsp - Genome Version <br/>
                          &nbsp &nbsp &nbsp &nbsp - Genome Version Release <br/>
                          &nbsp &nbsp &nbsp &nbsp - Cell Types or Tissues<span style='color:red'><strong>*</strong></span> <br/>
                         For each Cell Type or Tissue: <br/>
                          &nbsp &nbsp &nbsp &nbsp - Donors Names<span style='color:red'><strong>*</strong></span> <br/>
                          &nbsp &nbsp &nbsp &nbsp - # Replicates for each donor<span style='color:red'><strong>*</strong></span> <br/>
                          &nbsp &nbsp &nbsp &nbsp - # Inputs for each donor<span style='color:red'><strong>*</strong></span> <br/>
                          &nbsp &nbsp &nbsp &nbsp - paired-end(pe) or singled-end(pe) samples for each donor<span style='color:red'><strong>*</strong></span> <br/>
                        <span style='color:red'><strong>*</span>All items that need MORE than 1 element MUST be COMMA-SEPARATED</strong> <br/> <br/>")
        } else {
            return()
        }
    })

})
