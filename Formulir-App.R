library(shiny)

# Definisikan suatu vector untuk menyimpan informasi yang ingin disimpan/ditampilkan
variabel <- c("id","nama","usia","kelamin", "pengalaman_shiny", "berapa_tahun")


# # Simpan tanggapan (Form yang diisikan oleh user)
# # ---- Fungsi ini berfungsi untuk melakukan pengumpulan data ----
# saveData <- function(data) {
#     data <- as.data.frame(t(data))
#     if (exists("respon")) {
#         respon <<- rbind(respon, data)
#     } else {
#         respon <<- data
#     }
# }
# 
# # Muat semua respons yang sudah disimpan sebelumnya
# # ---- Fungsi ini berfungsi untuk memuat semua data yang sudah disimpan ----
# loadData <- function() {
#     if (exists("respon")) {
#         respon
#     }
# }


library(RMySQL)

saveData <- function(data) {

# # Buatkan Database baru
#     db <- dbConnect(MySQL(),
#                       user='root',
#                       password='',
#                       host='localhost')
#     dbExecute(db,"CREATE DATABASE formulir")

# Koneksi ke database
    db <- dbConnect(MySQL(),
                    user='root',
                    password='',
                    dbname='formulir',
                    host='localhost')
    # input / simpan tabel "respons" ke basis data
    # Buat Query pembaruan data dengan pengulangan
    query <- sprintf("INSERT INTO %s (%s) VALUES ('%s')","respon",
        paste(names(data), collapse = ", "),
        paste(data, collapse = "', '")
    )
    # Kirim permintaan pembaruan dan putuskan basis data
    dbGetQuery(db, query)
    dbDisconnect(db)
}

loadData <- function() {
    # Hubungkan ke database
    db <- dbConnect(MySQL(),
                    user='root',
                    password='',
                    dbname='formulir',
                    host='localhost')
    # Bangun Query pengambilan data
    query <- sprintf("SELECT * FROM %s", "respon")
    # Kirim kueri pengambilan data dan putuskan koneksi basis data
    data <- dbGetQuery(db, query)
    dbDisconnect(db)
    data
}

# Buatlah UI-nya untuk mengumpulkan beberapa informasi dari pengguna web atau apps.
shinyApp(
    ui = fluidPage(
        DT::dataTableOutput("respon", width = 300), tags$hr(),
        textInput("nama", "Nama", ""),
        numericInput("usia", "Usia", 17, min=1, max=120),
        selectInput("kelamin", "Jenis Kelamin", list("Pria", "Wanita")),
        checkboxInput("pengalaman_shiny", "Saya sudah pernah menggunakan Shiny", FALSE),
        sliderInput("berapa_tahun", "Jumlah tahun menggunakan R", 0, 15, 2, ticks = FALSE),
        actionButton("submit", "Submit")
    ),
    
# Buatlah Server-nya (Beck-end), bagian ini berfungsi untuk menyimpan respons
    server = function(input, output, session) {
        
# Setiap kali formulir diisikan, data akan disimpan pada bagian ini
        formData <- reactive({
            data <- sapply(variabel, function(x) input[[x]])
            data
        })
        
# Ketika tombol Submit diklik, simpan data formulir 
        observeEvent(input$submit, {
            saveData(formData())
        })
        
# Tampilkan semua respon sebelumnya
# (Perbarui respon pada saat Submit diklik)
        output$respon <- DT::renderDataTable({
            input$submit
            loadData()
        })     
    }
)
