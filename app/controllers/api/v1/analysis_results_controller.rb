class Api::V1::AnalysisResultsController < Api::V1::BaseController

  def index
    @analysis_results = current_user.analysis_results
  end

  def show
    @analysis_result = current_user.analysis_results.find(param[:id])
  end
end
