describe Logger do
    let (:non_verbose_logger) { Logger.new(false) }
    let (:verbose_logger) { Logger.new(true) }

    it 'logs if verbose is enabled' do
        expect do
            verbose_logger.log('Hello')
        end.to output("Hello\n").to_stdout
    end

    it 'does not log if verbose is disabled' do
        expect do
            non_verbose_logger.log('Hello')
        end.not_to output.to_stdout
    end
end
