function my-prompt-hostname -d "Output short hostname for the prompt"
    switch (path extension $hostname)
        case .pink
            echo -n $hostname
        case '*'
            echo -n (prompt_hostname)
    end
end
